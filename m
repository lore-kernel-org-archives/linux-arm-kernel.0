From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 29 Jun 2016 12:31:23 +0800
Subject: [PATCH 2/2 v16] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <CACvgo53002XCPLufbJHQLC1uL1nNS7_0gh=napedetmvT6FoSw@mail.gmail.com>
References: <1464861445-11086-1-git-send-email-jitao.shi@mediatek.com>
 <1464861445-11086-2-git-send-email-jitao.shi@mediatek.com>
 <CACvgo53002XCPLufbJHQLC1uL1nNS7_0gh=napedetmvT6FoSw@mail.gmail.com>
Message-ID: <CAGS+omDsDS5tx=+Efq8LWNd3-asU4r2h=-AE6vdKgfG-p6vdAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emil,

One answer inline below.  The rest I leave to Jitao...

[snip...]

On Fri, Jun 17, 2016 at 3:14 AM, Emil Velikov <emil.l.velikov@gmail.com> wrote:

>> +static ssize_t ps8640_update_fw_store(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     const char *buf, size_t count)
>> +{
>> +       struct i2c_client *client = to_i2c_client(dev);
>> +       struct ps8640 *ps_bridge = i2c_get_clientdata(client);
>> +       const struct firmware *fw;
>> +       int error;
>> +
>> +       error = request_firmware(&fw, PS_FW_NAME, dev);
> Can the device operate without a firmware ? If not, why is the
> firmware loaded so later/after user interaction (via sysfs) ? I don't
> recall any other driver in DRM to use such an approach.

The PS8640 has internal flash, so it should always already have a
working firmware.
This sysfs interface is useful for user space initiated field firmware updates.

Regards,
-Daniel

> Regards,
> Emil
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
