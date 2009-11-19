From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 19 Nov 2009 20:05:29 +0900
Subject: [PATCH 09/19] drivers: serial: add support for Samsung S5PC110
	SoC uart
In-Reply-To: <20091119103336.GB15460@sirena.org.uk>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
	<1258551194-16018-10-git-send-email-m.szyprowski@samsung.com>
	<1b68c6790911180614y355f656fs828177ecc845ec8e@mail.gmail.com>
	<20091118221345.GB4808@trinity.fluff.org>
	<1b68c6790911181844p3fb32525h11f79f942afb2d64@mail.gmail.com>
	<20091119103336.GB15460@sirena.org.uk>
Message-ID: <1b68c6790911190305w33e777e3n1ed6b172d67f1639@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 7:33 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Nov 19, 2009 at 11:44:14AM +0900, jassi brar wrote:
>
>> Let each platform code(SoC specific) define names of all possible
>> source clocks and let the board init code pass on the potential source
>> clocks by some bit-mask(or some other mechanism) while setting the
>> platform data.
>
> This is going to set off warnings from a clock API point of view -
> passing clock names around in platform data is usually a sign that
> something is very wrong. ?Keeping the mapping inside the clock API
> (still controlled by the board driver but by telling the clock API that
> device X should use clock Y).
no clock pointer needs to be passed, just a pointer to an array of _strings_
There is no need to even include any clock header in platform code
for the purpose.
