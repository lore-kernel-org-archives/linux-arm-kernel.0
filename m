From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Tue, 19 Mar 2013 12:10:11 +0100
Subject: [PATCH v3 0/9] refactoring for mask_cache
In-Reply-To: <20130319110620.GO13280@titan.lakedaemon.net>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com><20130319100352.GB2419@localhost>
 <20130319110620.GO13280@titan.lakedaemon.net>
Message-ID: <51484793.5020102@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 12:06 PM, Jason Cooper wrote:
> On Tue, Mar 19, 2013 at 07:03:53AM -0300, Ezequiel Garcia wrote:
>> Hi Gerlando,
>>
>> On Mon, Mar 18, 2013 at 03:00:46PM +0100, Gerlando Falauto wrote:
>>> here is a patchset to address the issue found with Orion, in incremental
>>> stages as Thomas suggested.
>>> a) we introduce the new fields and pointer (though only the shared one is used)
>>> b) we convert all drivers to use it
>>> c) we rename the field so to force the use of the per-ct pointer
>>> d) we add per-ct mask cache, provided the new flag
>>>     IRQ_GC_SEPARATE_MASK_REGISTERS is enabled
>>> e) we enable the flag for orion-gpio and mvebu drivers
>>>
>>> So even though I'm also providing changes for mvebu, I only
>>> tested the patch on a 3.0.40 kernel with the plat-orion/gpio.c driver.
>>
>> Great job! Since this is a really old bug you're fixing I believe that the
>> patchset applies for stable as well as mainline.
>>
>> According to Documentation/stable_kernel_rules.txt all you need to do
>> is add a 'Cc: stable at vger.kernel.org' tag in your sign-off area.
>>
>> Stable people will take care of picking the patch when it hits
>> mainline. You should receive a mail notification about patches
>> being included in stable kernels.
>
> Yes, and if you have an idea of when the regression was introduced,
> perhaps even which commit, that would be *extremely* helpful.

Uhm, you're right, that piece of information sort of got lost while 
reworking the whole thing (from a single patch to a 9-piece series!).
Here it is:

This fixes a regression introduced by e59347a
"arm: orion: Use generic irq chip".

Question is, where (out of the 9 patches) should that be mentioned?
On all of them?

> Otherwise, the stable folks have to expend a lot of time tracking it
> down.

Let's try and save them that... :-)

Thank you!
Gerlando
