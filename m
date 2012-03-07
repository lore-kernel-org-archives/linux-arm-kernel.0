From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Mar 2012 11:29:14 -0700
Subject: [PATCH 1/3] Kbuild: centralize MKIMAGE and cmd_uimage definitions
In-Reply-To: <CA+5PVA7PCow=Z7TpPtQYp3ye6uKFSp3XsdH75Pe9BRu9Vyy21g@mail.gmail.com>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
 <CA+5PVA7PCow=Z7TpPtQYp3ye6uKFSp3XsdH75Pe9BRu9Vyy21g@mail.gmail.com>
Message-ID: <4F57A8FA.8080208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2012 07:15 AM, Josh Boyer wrote:
> On Tue, Mar 6, 2012 at 7:30 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
>> to avoid duplication.
>>
>> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
>> parameterized version in Makefile.lib to avoid duplication.
>>
>> The centralized cmd_uimage definition will allow the future introduction
>> of a centralized Kconfig option to make cmd_uimage use -T kernel_noload
>> rather than -T kernel.
...
> Is there a reason you skipped powerpc?

grepping the powerpc makefiles showed no hits on MKIMAGE, mkimage or
cmd_uimage.

Looking a little harder now, this is all inside the shell script
arch/powerpc/boot/wrapper. I'm not really sure quite how to unify that
shell script with the makefile use of mkimage. Do you have any ideas?
