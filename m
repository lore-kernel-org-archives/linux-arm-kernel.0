From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Mon, 26 Jun 2017 19:46:34 +0200
Subject: [PATCH v1 2/6] [media] ov9650: add device tree support
In-Reply-To: <20170626163102.GQ12407@valkosipuli.retiisi.org.uk>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <1498143942-12682-3-git-send-email-hugues.fruchet@st.com>
 <20170626163102.GQ12407@valkosipuli.retiisi.org.uk>
Message-ID: <D780984B-70A1-4E9C-A887-DD2CBAAC7CCA@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Am 26.06.2017 um 18:31 schrieb Sakari Ailus <sakari.ailus@iki.fi>:
> 
> Hi Hugues,
> 
> On Thu, Jun 22, 2017 at 05:05:38PM +0200, Hugues Fruchet wrote:
>> @@ -1545,15 +1577,22 @@ static int ov965x_remove(struct i2c_client *client)
>> }
>> 
>> static const struct i2c_device_id ov965x_id[] = {
>> -	{ "OV9650", 0 },
>> -	{ "OV9652", 0 },
>> +	{ "OV9650", 0x9650 },
>> +	{ "OV9652", 0x9652 },
> 
> This change does not appear to match with the patch description nor it the
> information is used. How about not changing it, unless there's a reason to?
> The same for the data field of the of_device_id array below.

I think it could/should be used to check if the camera chip that is found
by reading the product-id and version registers does match what the device
tree expects and abort probing on a mismatch.

BR,
Nikolaus
