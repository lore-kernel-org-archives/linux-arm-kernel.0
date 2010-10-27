From: tfransosi@gmail.com (Thiago Farina)
Date: Wed, 27 Oct 2010 15:42:53 -0200
Subject: [PATCH v2 1/2] regulator: add support for regulators on the
	ab8500 MFD
In-Reply-To: <20101027173340.GA25134@opensource.wolfsonmicro.com>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<AANLkTinc50bzQawaoA_XfkLhJXjVjPWzxgbCJ40UnYwi@mail.gmail.com>
	<20101027173340.GA25134@opensource.wolfsonmicro.com>
Message-ID: <AANLkTi=DRHVbz3ov_gL6qyYH673WDk+1Vyw2AvjhSRxv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 3:33 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Oct 27, 2010 at 02:25:44PM -0200, Thiago Farina wrote:
>
>> Shouldn't be this returning 1 instead of true and 0 instead false
>> (since the return type is int not bool)?
>
> There is no reason to do this, logical values are treated as 0 and 1 in
> C. ?Using false and true is clear and won't cause any difference in
> code.
>
In C99 I suppose that is true and legal?

>> Maybe like this?
>> return (ret & info->mask) ? 1: 0;
>
> No, that's needlessly obfuscated.
>
Obfuscated? What you mean? It is a driver, and people reading and
writing a driver would know what it means, no?

Would be much simpler if it was just (like done in ab3100.c):

return (ret & info->mask);
