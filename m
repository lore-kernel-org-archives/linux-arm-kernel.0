From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 28 Apr 2016 14:54:39 +0200
Subject: [PATCH v6 2/2] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <20160428144607.191a29f2@bbrezillon>
References: <1461767754-12189-1-git-send-email-boris.brezillon@free-electrons.com>
 <1461767754-12189-3-git-send-email-boris.brezillon@free-electrons.com>
 <CACh+v5OO+UQ_EiWVyewdMHnMB-p3nd6N=R5P7K4V_4=ymy-YuQ@mail.gmail.com>
 <20160428104925.7eb12ca2@bbrezillon>
 <CACh+v5Mi2Qd58SZkwW0mZ3ZJx3Rv3mwSkRqzgHwBTxpUbwjVFQ@mail.gmail.com>
 <20160428144607.191a29f2@bbrezillon>
Message-ID: <CACh+v5ObRAf=7D3tbQdAzef+QRVObF_9eHJEreXwxVyrV8THcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-04-28 14:46 GMT+02:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
> On Thu, 28 Apr 2016 14:18:25 +0200
> Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:
>> >> > +
>> >> > +- atmel,ncs-rd-setup-ns
>> >> > +- atmel,nrd-setup-ns
>> >> > +- atmel,ncs-wr-setup-ns
>> >> > +- atmel,nwe-setup-ns
>> >> > +- atmel,ncs-rd-pulse-ns
>> >> > +- atmel,nrd-pulse-ns
>> >> > +- atmel,ncs-wr-pulse-ns
>> >> > +- atmel,nwe-pulse-ns
>> >> > +- atmel,nwe-cycle-ns
>> >> > +- atmel,nrd-cycle-ns
>> >> > +- atmel,tdf-ns
>> >>
>> >> One thought about the configuration in 'ns' unit: Some devices may
>> >> have requirements expressed in clock cycles (I'm thinking of FPGA
>> >> here). At  a fixed frequency one can always convert manually from 'ns'
>> >> to 'clocks' but it's a bit tedious and prone to rounding errors. And
>> >> It 'll  break when the EBI frequency is changed
>> >
>> > If you don't mind, I'd like to first get this version accepted, and
>> > we'll extend it with timings expressed in clock cycles afterward.
>> >
>> > BTW, could you describe a real use case where timings should be
>> > expressed in clock cycles? I mean, usually the devices have some timing
>> > constraints (tXX_min = Y ns), and I don't see why it would differ for
>> > FPGA interfaces, but I'm clearly not an FPGA expert.
>>
>> I'm not either, I only toyed with FPGA. That's just what experienced
>> FPGA designer told me.
>> I guess that it boils down to: FPGA are more suited for a synchronous
>> design than an asynchronous one.
>
> The thing is, all the timings are based on the master clock, and,
> AFAICS, this clk signal is not exposed, so you're basing your clk-cycle
while EBI itself is asynchronous, the clk can be exposed through one
of the PCK. I've seen this in real projects.
> based timings on something that can change depending on how the
> bootstrap/bootloader decided to configure the master clk.
>
> One option would be to define one of the timing as the reference,
> define this one in nanosecond, and define the other ones as multiple of
> the reference timing. But I'm not sure it's easier to do that than
> defining all the timings directly in nanoseconds.
>
> --
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
