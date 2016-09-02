From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Sep 2016 09:39:48 -0500
Subject: [PATCH v2 1/2] input: touchscreen: silead_gsl1680: Document
 firmware-name, fix implementation
In-Reply-To: <20160829192937.32129-2-hdegoede@redhat.com>
References: <20160829192937.32129-1-hdegoede@redhat.com>
 <20160829192937.32129-2-hdegoede@redhat.com>
Message-ID: <20160902143948.GA6214@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 09:29:36PM +0200, Hans de Goede wrote:
> The driver has supported touchscreen-fw-name to specify the firmware to
> load since it has been merged, but this was omitted from the dt-binding
> documentation.
> 
> During review of adding touchscreen-fw-name to the binding documentation
> it was brought up that there is a standard property name called
> "firmware-name" for this, which should be used.
> 
> Since there are no users of touchscreen-fw-name yet, this commit
> adds documentation of "firmware-name" to the dt-binding documentation
> and switches the driver over to use this.
> 
> This commit also makes the driver add a "silead/" prefix to the
> firmware name from dt before calling request_firmware. That the
> firmware files are stored under /lib/firmware/silead under Linux
> is an implementation detail and does not belong in devicetree.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt         | 1 +
>  drivers/input/touchscreen/silead.c                                   | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
