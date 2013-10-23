From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Oct 2013 17:49:06 +0100
Subject: [PATCHv4] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <20131023134236.GE17512@ns203013.ovh.net>
References: <20131019104555.GI18477@ns203013.ovh.net>
 <1382346813-8449-1-git-send-email-denis@eukrea.com>
 <20131022045833.GB17512@ns203013.ovh.net>
 <20131022072307.GA8681@ulmo.nvidia.com>
 <20131022153445.GD17512@ns203013.ovh.net> <20131022200141.GA8037@mithrandir>
 <20131023134236.GE17512@ns203013.ovh.net>
Message-ID: <5267FE02.6000001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2013 02:42 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
...
> For me gpio_get_value can return the value of a an output gpio but this need
> to be checked with LinusW

That's certainly not true for all possible GPIO controllers; there are
at least some that can't read either:

* The value of the physical wire, if the GPIO is configured as an output.

* The value that the GPIO controller is driving as an output.
