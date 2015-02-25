From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 25 Feb 2015 14:45:34 +0100
Subject: Ethernet Briding broken on APM Mustang on v4.0-rc1
In-Reply-To: <20150225124101.GD12827@cbox>
References: <20150225124101.GD12827@cbox>
Message-ID: <20150225134534.GE12827@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update, apologies for noise,

On Wed, Feb 25, 2015 at 01:41:01PM +0100, Christoffer Dall wrote:
> Hi,
> 
> Configuring bridged networking on the APM Mustang platform doesn't work
> on v4.0-rc1.  It works fine on v3.19-rc1.
> 
> When adding the interface to the bridge I get this error:
> 
> can't add eth0 to bridge br0: Invalid argument
> 
> Has anyone else seen this?
> 
> Other ARMv8 platforms don't seem to be affected by this.
> 

It seems that on v4.0-rc1 the APM ethernet card no longer gets a mac
address (or rather, it gets 00:00:00:00:...) so assigning it an
appropriate address naturally does the trick.

I have no idea which change caused this behavior though.

-Christoffer
