From: josh.coombs@gmail.com (Josh Coombs)
Date: Wed, 9 Jan 2013 13:45:50 -0500
Subject: [PATCH] Allow Marvell SATA driver to work with
 LEDS_TRIGGER_IDE_DISK
In-Reply-To: <50EDA154.6060407@pobox.com>
References: <1357668987-3610-1-git-send-email-josh.coombs@gmail.com>
 <50EDA154.6060407@pobox.com>
Message-ID: <CAMW5UfaTX=2fQt=+2KiJCgnnUzeOXM4waMjYgyBj=RfQg6pDcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Digging back through the archives, this came up once in 2007, Alan Cox
did not like the idea of globally adding this call into the critical
paths of libata at the time. (I've seen it done via external patches
in ata_qc_issue and ata_qc_complete for example.)  If that concern is
no longer in place, I can redo with it within libata so it'll work for
all libata driven devices similar to how it's handled for legacy IDE
drivers now.

Josh C

On Wed, Jan 9, 2013 at 11:56 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 01/08/2013 01:16 PM, Joshua Coombs wrote:
>>
>> Add a call to the IDE LED Trigger within the Marvell SATA driver to allow
>> Marvell SoC devices to show SATA activity via GPIO connected LEDs.
>>
>> Signed-off-by: Joshua Coombs <josh.coombs@gmail.com>
>> ---
>>   drivers/ata/sata_mv.c | 3 +++
>>   drivers/leds/Kconfig  | 3 +--
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>
>
> NAK.  This is not appropriate at the specific driver level.  This would be
> better implemented at a higher level.
>
>
>
