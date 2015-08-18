From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Aug 2015 14:46:08 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable CROS_EC_PROTO for
 ChromeOS EC mfd driver
In-Reply-To: <1439881827-22613-1-git-send-email-javier@osg.samsung.com>
References: <1439881827-22613-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20150818214608.GA21855@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 09:10:27AM +0200, Javier Martinez Canillas wrote:
> The ChromeOS mfd driver (MFD_CROS_EC) select the CROS_EC_PROTO config
> symbol because the driver uses some communication helper functions in
> drivers/platform/chrome/cros_ec_proto.c but other drivers depends on
> CROS_EC_PROTO instead. Mixing select and depends can lead to circular
> Kconfig dependencies so the MFD_CROS_EC select should be changed to a
> depends on CROS_EC_PROTO instead.
> 
> But doing so will break git bisect-ability since MFD_CROS_EC will not
> be enabled anymore unless the default configs first explicitly enable
> the CROS_EC_PROTO dependency.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied to cros/ec-config in arm-soc, which will stay stable in case others
need to bring in as a prereq.


-Olof
