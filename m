From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Fri, 5 Dec 2014 11:27:01 +0530
Subject: [PATCH v2 1/3] i2c: cadence: Handle > 252 byte transfers
In-Reply-To: <CAA7nrtg_G+U2EVxy0joZC+fBGyXS_uOwe1RZ8PyoDv7icu6OBw@mail.gmail.com>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
 <1417610126-7957-2-git-send-email-harinik@xilinx.com>
 <CAA7nrtg_G+U2EVxy0joZC+fBGyXS_uOwe1RZ8PyoDv7icu6OBw@mail.gmail.com>
Message-ID: <CAFcVECJtMJUAcjLTQ1eP=qBr2Lbf0DUy5dSE7f9UpT8a-9h6yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 5, 2014 at 11:11 AM, rajeev kumar
<rajeevkumar.linux@gmail.com> wrote:
> On Wed, Dec 3, 2014 at 6:05 PM, Harini Katakam <harinik@xilinx.com> wrote:
>> The I2C controller sends a NACK to the slave when transfer size register
>> reaches zero, irrespective of the hold bit. So, in order to handle transfers
>> greater than 252 bytes, the transfer size register has to be maintained at a
>> value >= 1. This patch implements the same.
>
> Why 252 Bytes ?  Is it word allign or what ?
>

It is the maximum transfer size that can be written that is a multiple of
the data interrupt (this occurs when the fifo has 14 bytes).
I will include an explanation in driver as well.

Regards,
Harini
