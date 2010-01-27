From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 27 Jan 2010 09:32:45 +0900
Subject: [PATCH 2/4] ARM: SAMSUNG: Rename s3c24xx touchscreen interface to
	s3c
In-Reply-To: <4B5F1229.9030304@gmail.com>
References: <b2e8f9f71001221447k897b5cfs213447084543ee55@mail.gmail.com>
	<20100126145558.GE9153@trinity.fluff.org> <4B5F1229.9030304@gmail.com>
Message-ID: <1b68c6791001261632y354b54c6v5845d33358a52179@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 1:02 AM, Maurus Cuelenaere
<mcuelenaere@gmail.com> wrote:
> Op 26-01-10 15:55, Ben Dooks schreef:
>>
>> On Fri, Jan 22, 2010 at 11:47:11PM +0100, Maurus Cuelenaere wrote:
>>
>>>
>>> ARM: SAMSUNG: Rename s3c24xx touchscreen interface to s3c
>>>
>>> Signed-off-by: Maurus Cuelenaere<mcuelenaere@gmail.com>
>>>
>>
>> Renaming for naming sake is in my view just a waste of diff, unless
>> anyone disagrees here.
>>
>
> Well I don't think it's pointless, having s3c24xx_ts_set_platdata() and
> s3c2410_ts_mach_info instead of their s3c_ equivalents make it look like the
> API only handles s3c24xx platforms, which isn't true (anymore).
well, even after making it s3c_ it still doesn't cover s5pxxxx(and its not
just ts but other devices as well). The point is, we can't ever catch up
with the SoC names.

A more soothing pov is to see newer devices as containing the ts
controller of s3c2410(in this case).
If not that, then no point in renaming just ts, we should rename every
other such symbol to not s3c_ but samsung_<dev>_ver_abc_
or some more compact form otherwise we fall back in the same dilemma.
