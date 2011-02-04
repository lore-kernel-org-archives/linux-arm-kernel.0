From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Thu, 3 Feb 2011 16:30:46 -0800
Subject: [PATCH 1/5] ARM: etm: Don't require clock control
In-Reply-To: <20110203124521.GK9810@sirena.org.uk>
References: <1296701663-12168-1-git-send-email-arve@android.com>
	<20110203124521.GK9810@sirena.org.uk>
Message-ID: <AANLkTikybaV-jBo-q4Xb_POC5QRG9RRRV1RCDOnX9riG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 3, 2011 at 4:45 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Feb 02, 2011 at 06:54:19PM -0800, Arve Hj??nnev??g wrote:
>> If clk_get fail, assume the etb does not need a separate clock.
>>
>> Signed-off-by: Arve Hj??nnev??g <arve@android.com>
>
> Would it not be cleaner for the affected platforms to ensure that
> clk_get() does the right thing here, for example by returning a dummy
> clock? ?Otherwise we'll just silently carry on if we can't get a clock
> we were supposed to which doesn't seem ideal.
>

This clock seem to be an omap specific virtual clock that switches the
clock source of the etb. It is not used to enable the clock when the
etb is in use, and it does not seem to have a failure case other than
not existing. So, I don't know that requiring this clock would cause
fewer problems than making it optional.

--
Arve Hj?nnev?g
