From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue, 3 Apr 2018 13:26:34 +0300
Subject: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
In-Reply-To: <20180403081041.3ully6bcyfwx2cx6@flea>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-3-ssuloev@orpaltech.com>
 <20180403081041.3ully6bcyfwx2cx6@flea>
Message-ID: <c3b41806-dc12-3af9-8b3a-bd1a611293f8@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2018 11:10 AM, Maxime Ripard wrote:
> On Thu, Mar 29, 2018 at 09:59:03PM +0300, Sergey Suloev wrote:
>> There is no need to handle 3/4 empty/full interrupts as the maximum
>> supported transfer length in PIO mode is 64 bytes for sun4i-family
>> SoCs.
> That assumes that you'll be able to treat the FIFO full interrupt and
> drain the FIFO before we have the next byte coming in. This would
> require a real time system, and we're not in one of them.
>
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

so you think we should still handle 3/4 FIFO full ?
