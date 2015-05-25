From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 25 May 2015 10:59:43 -0600
Subject: [PATCH] coresight: etb: Remove simple announcement message
In-Reply-To: <20150522163327.GU21577@sirena.org.uk>
References: <1432122101-2233-1-git-send-email-broonie@kernel.org>
 <CANLsYkyW44THumc5ebWnX-sa5zG7X0dv1_UEqUp9Av8c5PDegg@mail.gmail.com>
 <20150522163327.GU21577@sirena.org.uk>
Message-ID: <CANLsYkwT3WR7Wxy_biWwXdzSsWjMptNdr38d+_1OhiTTnzm5NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 2015 at 10:33, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 22, 2015 at 08:17:21AM -0600, Mathieu Poirier wrote:
>
>> Linus Walleij started doing something interesting with the initial
>> printouts [1] and I think this is a better option than not printing
>> anything at all.
>
> It's definitely better to print information we enumerate from hardware,
> though I'm not 100% sure if AMBA does the right thing with matching here
> (most of the buses ignore hardware IDs in favour of DT information if
> things are bound via DT).

AMBA has been done properly - bypassing the initial ID lookup with the
"arm,primecell-periphid" binding only prevent the HW from being
accessed when the DT is parsed.  At driver init time the peripheral ID
from the DT is checked against the list of AMBA IDs supported by the
driver and fails if a match is not found.

One can always force things with the "driver-override" sysfs property
but that's another story.
