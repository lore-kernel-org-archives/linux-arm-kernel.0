From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Oct 2010 10:33:41 -0700
Subject: [PATCH v2 1/2] regulator: add support for regulators on the
	ab8500 MFD
In-Reply-To: <AANLkTinc50bzQawaoA_XfkLhJXjVjPWzxgbCJ40UnYwi@mail.gmail.com>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<AANLkTinc50bzQawaoA_XfkLhJXjVjPWzxgbCJ40UnYwi@mail.gmail.com>
Message-ID: <20101027173340.GA25134@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 02:25:44PM -0200, Thiago Farina wrote:

> Shouldn't be this returning 1 instead of true and 0 instead false
> (since the return type is int not bool)?

There is no reason to do this, logical values are treated as 0 and 1 in
C.  Using false and true is clear and won't cause any difference in
code.

> Maybe like this?
> return (ret & info->mask) ? 1: 0;

No, that's needlessly obfuscated.
