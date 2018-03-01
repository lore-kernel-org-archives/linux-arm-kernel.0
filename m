From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Mar 2018 23:12:15 +0100
Subject: [PATCH] drm/bridge: sii902x: Fall back to standard modes
In-Reply-To: <20180301211840.GD5453@intel.com>
References: <20180214130059.19052-1-linus.walleij@linaro.org>
 <CACRpkdYuZE+ohhLf6mmPHEsGmNw6r7UOBCyQEFOcYOYxdVj2oA@mail.gmail.com>
 <20180301211840.GD5453@intel.com>
Message-ID: <CACRpkdbMfzWSH1bAtjhW_ykJGPnycVFtbUp816KShX5wCDu+0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 1, 2018 at 10:18 PM, Ville Syrj?l?
<ville.syrjala@linux.intel.com> wrote:
> On Thu, Mar 01, 2018 at 10:02:55PM +0100, Linus Walleij wrote:
>> Hm, hard to get review feedback on this one.
>>
>> It gives me proper video on an ARM Versatile Express utilizing the
>> bridge driver with a plugged in DVI-to-VGA dongle with the new
>> PL111 DRI driver.
>>
>> Liviu? Pawel?
>>
>> Some ACK is fine to know I am doing the right thing :)
>
> Why isn't the probe helper's noedid fallback working?

Where is that in the call chain?

The problem I have is that the bridge is there, it gets properly
initialized and used as connector and all. The only problem is
that the DDI I2C portion of it is not working, so no modes are
really added from the struct drm_connector_helper_funcs
.get_modes() callback.

Yours,
Linus Walleij
