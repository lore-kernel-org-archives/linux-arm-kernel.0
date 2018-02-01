From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Feb 2018 14:24:55 +0000
Subject: [alsa-devel] [PATCH 1/1] ASoC: stm32: add of dependency for
 stm32 drivers
In-Reply-To: <3bd3ba89-5c69-4485-c913-ff1c1ad67190@st.com>
References: <1517475281-6444-1-git-send-email-olivier.moysan@st.com>
 <20180201091012.GA10746@lenoch>
 <3bd3ba89-5c69-4485-c913-ff1c1ad67190@st.com>
Message-ID: <20180201142455.GB10785@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 01:19:28PM +0000, Olivier MOYSAN wrote:
> On 02/01/2018 10:10 AM, Ladislav Michl wrote:

> > depends on (ARCH_STM32 && OF) || COMPILE_TEST ?

> I can find in many configs "depends on OF && (ARCH_X || COMPILE_TEST)"
> This seems reasonable to me, as the driver always requires OF 
> dependency, regardless the compilation context.
> In fact, I cannot see why OF would not have to be selected
> for COMPILE_TEST.

There are some OF functions that are stubbed out when OF is disabled and
some that aren't, if the driver is using the more obscure APIs that
aren't stubbed it needs the hard dependency but if it's using the other
bits that do have the stubs then it can be compile tested without OF
being abled.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180201/01601556/attachment-0001.sig>
