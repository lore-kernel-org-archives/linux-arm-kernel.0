From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Fri, 5 Dec 2014 09:42:30 +0530
Subject: [PATCH v2 3/3] i2c: cadence: Check for errata condition involving
 master receive
In-Reply-To: <20141204183406.GK7944@katana>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
 <1417610126-7957-4-git-send-email-harinik@xilinx.com>
 <20141204183406.GK7944@katana>
Message-ID: <CAFcVECL0ShFp-qSHmO8era3okebA4oO85iz+QRWP6fKAEMiN7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 5, 2014 at 12:04 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> +             /*
>> +              * This controller does not give completion interrupt after a
>> +              * master receive transfer if HOLD bit is set (repeated start),
>> +              * resulting in SW timeout. Hence, if a receive transfer is
>> +              * followed by any other transfer, an error is returned
>> +              * indicating that this sequence is not supported.
>> +              */
>> +             for (count = 0; count < num-1; count++) {
>> +                     if (msgs[count].flags & I2C_M_RD)
>> +                             return -EOPNOTSUPP;
>> +             }
>
> Yeah, a lot better. Probably it would be good to inform the user with a
> warning what went wrong?
>

Sure. I'll add that.

Regards,
Harini
