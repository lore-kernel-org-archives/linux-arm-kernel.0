From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 3 Feb 2010 07:16:53 -0800
Subject: [PATCHv2 04/11] mxc: changes to common plat-mxc code to add
	support for i.MX5
In-Reply-To: <20100203133840.GD5252@k2>
References: <cover.1265173246.git.amit.kucheria@verdurent.com>
	<0511204199ab83aed2340e70a4639500c0528dab.1265173480.git.amit.kucheria@canonical.com>
	<9fa7a3c70c46a1f776c6520051481cff6525ef02.1265173480.git.amit.kucheria@canonical.com>
	<cover.1265173480.git.amit.kucheria@canonical.com>
	<ccc89dd7a6035abf5a78680404a2b30b9e025353.1265173480.git.amit.kucheria@canonical.com>
	<ec63e5978fd5ac5d308ede5916e648ba925818eb.1265173480.git.amit.kucheria@canonical.com>
	<f17812d71002022243s7b68dab0ycc19238535384d4f@mail.gmail.com>
	<20100203094959.GN6130@pengutronix.de> <20100203133840.GD5252@k2>
Message-ID: <f17812d71002030716y7e6eb65ei78d3ef78ecf03ad4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2010 at 5:38 AM, Amit Kucheria
<amit.kucheria@canonical.com> wrote:
> On 10 Feb 03, Sascha Hauer wrote:
>> On Tue, Feb 02, 2010 at 10:43:33PM -0800, Eric Miao wrote:
>> >
>> > Mmm.... this should be something that we really need to get rid of, it just
>> > makes a single kernel for both TZIC and AVIC together impossible, if that's
>> > so designed by HW, I'm thinking about keeping this into plat-mxc/ is a good
>> > way to go ...
>> >
>> > Sascha, you have any better idea? Provided the other file debug-macro.S in
>> > the same directory already seems to break the support for multiple arches?
>> >
>>
>> I have the following patch which I'm not sure I like better. It can
>> support both irq controller types and does not add overhead if only one
>> of them is compiled in. It might need some refactoring to fit into Amits
>> patch stack.
>
> Is co-existence of TZIC and AVIC a blocker to merging i.MX5 code? I've
> already made changes so that i.MX5 doesn't explode if AVIC is compiled in.
>
> Admittedly the assembly is a bit hard to rid, but we can fix in another set
> of patches geared towards unification of an i.MX kernel. IMHO, making these
> changes along with introducing a new SoC will make things a bit hard to
> follow/merge.
>

I personally don't feel that's a hard requirement, as long as it can be fixed.
