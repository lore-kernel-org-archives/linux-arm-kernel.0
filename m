From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Tue, 27 Jun 2017 08:36:42 +0300
Subject: [PATCH v1 2/6] [media] ov9650: add device tree support
In-Reply-To: <D780984B-70A1-4E9C-A887-DD2CBAAC7CCA@goldelico.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <1498143942-12682-3-git-send-email-hugues.fruchet@st.com>
 <20170626163102.GQ12407@valkosipuli.retiisi.org.uk>
 <D780984B-70A1-4E9C-A887-DD2CBAAC7CCA@goldelico.com>
Message-ID: <20170627053642.GW12407@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 07:46:34PM +0200, H. Nikolaus Schaller wrote:
> Hi,
> 
> > Am 26.06.2017 um 18:31 schrieb Sakari Ailus <sakari.ailus@iki.fi>:
> > 
> > Hi Hugues,
> > 
> > On Thu, Jun 22, 2017 at 05:05:38PM +0200, Hugues Fruchet wrote:
> >> @@ -1545,15 +1577,22 @@ static int ov965x_remove(struct i2c_client *client)
> >> }
> >> 
> >> static const struct i2c_device_id ov965x_id[] = {
> >> -	{ "OV9650", 0 },
> >> -	{ "OV9652", 0 },
> >> +	{ "OV9650", 0x9650 },
> >> +	{ "OV9652", 0x9652 },
> > 
> > This change does not appear to match with the patch description nor it the
> > information is used. How about not changing it, unless there's a reason to?
> > The same for the data field of the of_device_id array below.
> 
> I think it could/should be used to check if the camera chip that is found
> by reading the product-id and version registers does match what the device
> tree expects and abort probing on a mismatch.

Makes sense. But it should be a separate patch, shouldn't it?

You could also put the id to the ops struct, and choose the ops struct that
way. Entirely up to you.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
