From: nikolay@cumulusnetworks.com (Nikolay Aleksandrov)
Date: Tue, 6 Oct 2015 23:02:45 +0200
Subject: [PATCH] bridge/netfilter: avoid unused label warning
In-Reply-To: <5966552.c0Emgm27oa@wuerfel>
References: <7985748.1v9Gzszd4T@wuerfel> <561420DD.70009@cumulusnetworks.com>
 <5966552.c0Emgm27oa@wuerfel>
Message-ID: <561436F5.70409@cumulusnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2015 09:39 PM, Arnd Bergmann wrote:
> On Tuesday 06 October 2015 21:28:29 Nikolay Aleksandrov wrote:
>> I posted a fix for this a couple of days ago, but I like your approach better.
>> Since mine is not yet applied (I sent it to netfilter-devel only, wasn't sure which
>> jurisdiction this falls into exactly) we can drop it.
>> Just for reference my patch is here:
>> http://patchwork.ozlabs.org/patch/526417/
>> Pablo, could you please drop it ?
>>
>> By the way this takes care of another warning about unused variable (nf_bridge), too.
> 
> Hmm I did not get that one, at least not in 4.3-rc4.
> 
You need to set W=1
$ git describe --abbrev=0
v4.3-rc4

net/bridge//br_netfilter_hooks.c: In function ?br_nf_dev_queue_xmit?:
net/bridge//br_netfilter_hooks.c:794:2: warning: label ?drop? defined but not used [-Wunused-label]
  drop:
  ^
net/bridge//br_netfilter_hooks.c:727:25: warning: variable ?nf_bridge? set but not used [-Wunused-but-set-variable]
  struct nf_bridge_info *nf_bridge;

Cheers,
 Nik

>> Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> Thanks and sorry for missing the Cc to the netfilter list on my patch.
> 
> 	Arnd
