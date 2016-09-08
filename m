From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 7 Sep 2016 19:58:09 -0500
Subject: [PATCH v4 01/22] of: device: Support loading a module with OF
 based modalias
In-Reply-To: <20160907213519.27340-2-stephen.boyd@linaro.org>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <20160907213519.27340-2-stephen.boyd@linaro.org>
Message-ID: <CAL_JsqLC-ucq03wLY65mwYXQJHC_mVoK3LOMfpXVpYhKXssLgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 4:34 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> In the case of ULPI devices, we want to be able to load the
> driver before registering the device so that we don't get stuck
> in a loop waiting for the phy module to appear and failing usb
> controller probe. Currently we request the ulpi module via the
> ulpi ids, but in the DT case we might need to request it with the
> OF based modalias instead. Add a common function that allows
> anyone to request a module with the OF based modalias.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/of/device.c       | 23 +++++++++++++++++++++++
>  include/linux/of_device.h |  6 ++++++
>  2 files changed, 29 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
