From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 4 Feb 2010 12:51:16 -0800
Subject: [RFC PATCH 1/3] [ARM] allow NR_IRQS to be larger than 256
In-Reply-To: <20100204200504.GG27344@n2100.arm.linux.org.uk>
References: <f17812d71002041109u3d7ea08ej201708fa462e087d@mail.gmail.com>
	<4B6B2030.3040306@xenomai.org>
	<20100204200504.GG27344@n2100.arm.linux.org.uk>
Message-ID: <f17812d71002041251p585a0ea7h15a3da093f405e26@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 4, 2010 at 12:05 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 04, 2010 at 08:29:52PM +0100, Gilles Chanteperdrix wrote:
>> Eric Miao wrote:
>> > -#if NR_IRQS > 256
>> > +#if NR_IRQS > 512
>> > +#define HARDIRQ_BITS ? ? ? 10
>> > +#elif NR_IRQS > 256
>> > ?#define HARDIRQ_BITS ? ? ? 9
>> > ?#else
>> > ?#define HARDIRQ_BITS ? ? ? 8
>>
>> Would not it be possible to use
>>
>> #define HARDIRQ_BITS order_base_2(NR_IRQS)
>
> HARDIRQ_BITS must be a preprocessor constant.
>

Confirmed, log_order_2() won't compile.
