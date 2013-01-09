From: jgarzik@pobox.com (Jeff Garzik)
Date: Wed, 09 Jan 2013 11:56:52 -0500
Subject: [PATCH] Allow Marvell SATA driver to work with
 LEDS_TRIGGER_IDE_DISK
In-Reply-To: <1357668987-3610-1-git-send-email-josh.coombs@gmail.com>
References: <1357668987-3610-1-git-send-email-josh.coombs@gmail.com>
Message-ID: <50EDA154.6060407@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 01:16 PM, Joshua Coombs wrote:
> Add a call to the IDE LED Trigger within the Marvell SATA driver to allow
> Marvell SoC devices to show SATA activity via GPIO connected LEDs.
>
> Signed-off-by: Joshua Coombs <josh.coombs@gmail.com>
> ---
>   drivers/ata/sata_mv.c | 3 +++
>   drivers/leds/Kconfig  | 3 +--
>   2 files changed, 4 insertions(+), 2 deletions(-)

NAK.  This is not appropriate at the specific driver level.  This would 
be better implemented at a higher level.
