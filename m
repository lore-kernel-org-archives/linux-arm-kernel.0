From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 09 Nov 2014 22:05:26 +0100
Subject: [PATCH] ARM: dts: sunxi: Banana Pi: increase startup-delay for
 the GMAC PHY regulator
In-Reply-To: <1415539714-7652-2-git-send-email-merker@debian.org>
References: <1415539714-7652-1-git-send-email-merker@debian.org>
 <1415539714-7652-2-git-send-email-merker@debian.org>
Message-ID: <545FD716.5060305@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/09/2014 02:28 PM, Karsten Merker wrote:
> On the LeMaker Banana Pi, probing the external ethernet PHY connected
> to the SoC's internal GMAC module sometimes fails.  The PHY power
> supply is handled via a GPIO-controlled regulator, and the existing
> regulator startup-delay of 50000us is too short to make sure that the
> PHY is always fully powered up when it is queried by phylib.  To
> guarantee a reliable PHY detection, the startup-delay has to be
> increased to 60000us.

We should probably just increase it to 100000us to be safe, otherwise:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
