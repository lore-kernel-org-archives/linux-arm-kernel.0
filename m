From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Wed, 3 Feb 2010 10:33:16 -0800
Subject: [PATCHv2 08/11] fec: fix uninitialized rx buffer usage
In-Reply-To: <fa686aa41002030846v5044d585w7f4291f89c4b7ad@mail.gmail.com>
References: <cover.1265173246.git.amit.kucheria@verdurent.com>
	<9fa7a3c70c46a1f776c6520051481cff6525ef02.1265173480.git.amit.kucheria@canonical.com>
	<ccc89dd7a6035abf5a78680404a2b30b9e025353.1265173480.git.amit.kucheria@canonical.com>
	<ec63e5978fd5ac5d308ede5916e648ba925818eb.1265173480.git.amit.kucheria@canonical.com>
	<f10f79e7313ecdeeb59ab881795baedf2430c636.1265173480.git.amit.kucheria@canonical.com>
	<240f12ca87d7666f31263aabc620a9ec197cd8ff.1265173480.git.amit.kucheria@canonical.com>
	<cover.1265173480.git.amit.kucheria@canonical.com>
	<752ae69adb57d4f73fa011ba380cea1b927b9c8b.1265173480.git.amit.kucheria@canonical.com>
	<e46b06510f7eb6ca51ea8b96335b2d32ec8bf6f8.1265173480.git.amit.kucheria@canonical.com>
	<fa686aa41002030846v5044d585w7f4291f89c4b7ad@mail.gmail.com>
Message-ID: <37786d4b1002031033s15d0b24et82c3f0e45112ae65@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2010 at 8:46 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, Feb 2, 2010 at 10:16 PM, Amit Kucheria
> <amit.kucheria@canonical.com> wrote:
>> From: Rob Herring <r.herring@freescale.com>
>>
>> The fec driver was enabling receive buffer descriptor without allocating
>> the buffers. Make sure the buffer descriptors are initialized to not
>> start receiving packets.
>>
>> Open also calls fec_restart after the rx buffers are allocated. With the code
>> in fec_restart, it zeroes out the buffer descriptors that have just been
>> setup.
>
> fec related patches 8 & 9 look okay to me.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.

Can I take that as an Acked-by?
