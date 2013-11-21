From: olof@lixom.net (Olof Johansson)
Date: Thu, 21 Nov 2013 15:36:47 -0800
Subject: [PATCH V5] kbuild: dtbs_install: new make target
In-Reply-To: <653B066B-5B24-4817-86EF-D4D9F129123D@codeaurora.org>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1385062552-9882-1-git-send-email-jason@lakedaemon.net>
 <653B066B-5B24-4817-86EF-D4D9F129123D@codeaurora.org>
Message-ID: <CAOesGMjsYxhjpg7Gsw69-x5v5XgZ1NZifJ+z48sMizfdMW-tAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 3:31 PM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Nov 21, 2013, at 1:35 PM, Jason Cooper <jason@lakedaemon.net> wrote:
>
>> Unlike other build products in the Linux kernel, there is no 'make
>> *install' mechanism to put devicetree blobs in a standard place.
>>
>> This patch is an attempt to fix this problem.  Akin to 'make install',
>> this creates a new make target, dtbs_install.  The script that gets
>> called defers to a distribution or user supplied installdtbs binary,
>> if found in the system.  Otherwise, the default action is to install a
>> given dtb into
>>
>>  /boot/devicetrees/${kernel_version}/${dts_filename}.dtb

Random bikeshed of the day. Maybe this was already covered in the long
thread and just tell me to shut up and go away if it was and I'm not
presenting new arguments:

I like this whole approach, but I'm all for shorter pathnames as long
as they are unique. Also, keeping it below 8 can be useful for FAT
/boot filesystems. I propose /boot/dtb/ instead.


-Olof
