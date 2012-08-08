From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 8 Aug 2012 08:05:50 -0600 (MDT)
Subject: [PATCH 1/1] ARM: OMAP2+: hwmod: Print an error message if no
 match exists for a hwmod class
In-Reply-To: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com>
References: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <alpine.DEB.2.00.1208080803560.5447@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vaibhav,

On Wed, 8 Aug 2012, Vaibhav Bedia wrote:

> If no match is found for a hwmod class, omap_hwmod_for_each_by_class()
> currently does not spit out any error messages. To make debugging
> issues related to non-existent hwmod classes simpler make this function
> print an error message in case no match is found for the supplied hwmod
> class.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

It doesn't seem to me that this would necessarily always be an error.  
Suppose some init code to create cpsw devices is running on an OMAP3430.  
Then a omap_hwmod_for_each_by_class() that doesn't locate anything 
wouldn't be an error, right?


- Paul
