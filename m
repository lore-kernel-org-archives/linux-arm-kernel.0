From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Tue, 9 Jun 2015 09:42:28 +0530
Subject: [PATCH V2 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
In-Reply-To: <20150608091244.GS7557@n2100.arm.linux.org.uk>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150608091244.GS7557@n2100.arm.linux.org.uk>
Message-ID: <557667AC.3030506@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 02:42 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 01, 2015 at 10:51:06AM +0530, Bhuvanchandra DV wrote:
>> +    /*
>> +     * CTS/RTS can _only_ be handled
>> +     * automatically by the hardware.
>> +     */
>
> That's really not acceptable.  You need to do something here so that you
> can _force_ RTS to be deasserted when the kernel buffers fill up - be
> that by stopping reading characters and letting the FIFO fill up or
> something of that ilk.
Agreed, will fix this.
>
> Ignoring the rest of the flow control system in the kernel is not really
> acceptable.
>

Best regards,
Bhuvan
