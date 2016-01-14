From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 14 Jan 2016 12:18:16 -0800
Subject: [PATCH 1/3] ti-st: use device handles and add device tree binding
In-Reply-To: <20160114170746.GO12777@atomide.com>
References: <1450870253-8694-1-git-send-email-eyalr@ti.com>
 <8665E2433BC68541A24DFFCA87B70F5B23769B75@DFRE01.ent.ti.com>
 <20160114170746.GO12777@atomide.com>
Message-ID: <56980288.9030404@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2016 09:07 AM, Tony Lindgren wrote:
> * Reizer, Eyal <eyalr@ti.com> [160114 06:23]:
>> Ping on this patchset
> 
> I think there are several comments pending from Rob as
> a reply to this thread on December 29th?

That, and this driver has _serious_ architectural problems that I don't
see being worked on at all.

For example, when this driver loads and *waits for up to 5 seconds* [1]
for a userspace component _that may not even be loaded at the time_
is ridiculous.

Please fix the serious flaws first.

Regards,
Peter Hurley

[1] see st_kim_start()
