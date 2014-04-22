From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Apr 2014 14:17:30 +0200
Subject: [PATCH v8 00/17] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
In-Reply-To: <53565B74.4000703@elopez.com.ar>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <53565B74.4000703@elopez.com.ar>
Message-ID: <53565DDA.9020202@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/22/2014 02:07 PM, Emilio L?pez wrote:
> Hi Hans,
> 
> El 22/04/14 08:01, Hans de Goede escribi?:
>> Hi All,
>>
>> Here is v8 of the sunxi-mmc patch-set David Lanzend?rfer and I have been
>> working on.
>>
>> The first 2 patches are depenencies which should go in through the clk tree,
>> Mike can you pick these 2 up please ?  :
>>
>> "clk: sunxi: factors: automatic reparenting support"
>> Is uncontroversial and has been favorably reviewed by various people.
> 
> I'll pick this one up for 3.16 if you're ok with that. Mike, let me know if you have any objection to the patch, but I'm pretty sure you (informally?) acked it in the past.
> 
>> "clk: sunxi: Implement MMC phase control"
>> Is somewhat more controversial as there has been lots of discussion about
>> adding a generic phase control method to the clk framework. The problem is
>> that there has been a lot of talk about such a generic phase control method
>> but not a single patch. Therefor I would like to move forwards with using
>> a platform specific method for now. I hereby promise that once we've a generic
>> method I'll write patches to convert the sunxi code to that method.
> 
> Mike proposed a RFC for handling this better, and there were talks with Allwinner people to see what did these phase controls actually mean. We should be able to get a proper solution for it during this cycle. I'd prefer to work towards that instead of merging this, as we have more than a month to get it ready still.

A month will be gone before you know it, and merging sunxi mmc support really
is long overdue, and is the last thing keeping distros from shipping with sunxi
support ootb. So I would really prefer to just get this merged as is for now,
changing it later should be easy, and merging an interim solution will make
some more time for doing the generic clk phase control method properly.

Regards,

Hans
