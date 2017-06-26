From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 13:56:32 -0500
Subject: [PATCH v1 1/6] DT bindings: add bindings for ov965x camera module
In-Reply-To: <D5629236-95D8-45B6-9719-E8B9796FEC90@goldelico.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <1498143942-12682-2-git-send-email-hugues.fruchet@st.com>
 <D5629236-95D8-45B6-9719-E8B9796FEC90@goldelico.com>
Message-ID: <20170626185632.bfwuogm62ouo5y2j@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 12:25:33PM +0200, H. Nikolaus Schaller wrote:
> Hi Hugues,
> 
> > Am 22.06.2017 um 17:05 schrieb Hugues Fruchet <hugues.fruchet@st.com>:
> > 
> > From: "H. Nikolaus Schaller" <hns@goldelico.com>
> > 
> > This adds documentation of device tree bindings
> > for the OV965X family camera sensor module.
> > 
> > Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> > Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
> > ---
> > .../devicetree/bindings/media/i2c/ov965x.txt       | 37 ++++++++++++++++++++++
> > 1 file changed, 37 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/media/i2c/ov965x.txt

[...]

> > +Optional Properties:
> > +- resetb-gpios: reference to the GPIO connected to the resetb pin, if any.
> > +- pwdn-gpios: reference to the GPIO connected to the pwdn pin, if any.
> 
> Here I wonder why you did split that up into two gpios. Each "*-gpios" can have
> multiple entries and if one is not used, a 0 can be specified to make it being ignored.
> 
> But it is up to DT maintainers what they prefer: separate single gpios or a single gpio array.

I think that is pretty clear if you survey a number of bindings (hint: 
it's the former).

Rob
