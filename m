From: dtor@chromium.org (Dmitry Torokhov)
Date: Fri, 6 Feb 2015 14:48:31 -0800
Subject: [v7,2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <20150206223149.GB345@google.com>
References: <1421704310-26857-3-git-send-email-rjui@broadcom.com>
 <20150206223149.GB345@google.com>
Message-ID: <CAE_wzQ-POweLLmTyHoMvs_NESjW5UmPxh2ZQCaW4-W74MsrHag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 6, 2015 at 2:31 PM, Kevin Cernekee <cernekee@chromium.org> wrote:
> On Mon, Jan 19, 2015 at 01:51:49PM -0800, Ray Jui wrote:
>> +
>> +     dev_dbg(iproc_i2c->device, "xfer %c, addr=0x%02x, len=%d\n",
>> +             (msg->flags & I2C_M_RD) ? 'R' : 'W', msg->addr,
>> +             msg->len);
>> +     dev_dbg(iproc_i2c->device, "**** data start ****\n");
>> +     for (i = 0; i < msg->len; i++)
>> +             dev_dbg(iproc_i2c->device, "0x%02x ",  msg->buf[i]);
>> +     dev_dbg(iproc_i2c->device, "**** data end ****\n");
>
> It might be simpler to just do:
>
>     print_hex_dump_bytes("iproc_i2c:", DUMP_PREFIX_NONE, msg->buf, msg->len);
>
> although you'd lose the ability to see the I2C device name.

We can also do:

dev_dbg(iproc_i2c->device, "*** data: %*ph\n", msg->len, msg->buf);

if we are OK with limiting output to 64 bytes.

Thanks,
Dmitry
