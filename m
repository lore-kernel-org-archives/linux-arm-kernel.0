From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Mon, 2 Jan 2017 17:13:34 +0530
Subject: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <20170102113155.GA16373@localhost.localdomain>
References: <1481720175-12703-1-git-send-email-andrei.pistirica@microchip.com>
 <BN3PR07MB2516815EDE69ACDCE27F81A3C96F0@BN3PR07MB2516.namprd07.prod.outlook.com>
 <20170102113155.GA16373@localhost.localdomain>
Message-ID: <CAFcVECLg-hXvfgwRW-fxi+N0k=7pTaEMhS5EMXV9_OO+xGRUqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Mon, Jan 2, 2017 at 5:01 PM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Mon, Jan 02, 2017 at 09:36:10AM +0000, Rafal Ozieblo wrote:
>> According Cadence Hardware team:
>> "It is just that some customers prefer to have the time in the descriptors as that is provided per frame.
>> The registers are simply overwritten when a new event frame is transmitted/received and so software could miss it."
>> The question is are you sure that you read timestamp for current frame? (not for the next frame).
>
> AFAICT, having the time stamp in the descriptor is not universally
> supported.  Looking at the Xilinx Zynq 7000 TRM, I can't find any
> mention of this.
>
> This Cadence IP core is a complete disaster.
>
> Unless someone can tell us how this IP works in all of its
> incarnations, this series is going nowhere.

>From the revision history of Cadence spec, all versions starting
r1p02 have ability to include timestamp in descriptors.
For previous versions the event register is the only option.
But yes, there have been multiple enhancements and
bug fixes in this IP w.r.t PTP making each implementation
different.

Regards,
Harini
