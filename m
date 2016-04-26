From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 26 Apr 2016 12:02:29 +0100
Subject: [PATCH 09/18] ASoC: sti: Update DT example to match the driver
 code
In-Reply-To: <20160421155753.GS3217@sirena.org.uk>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-10-git-send-email-peter.griffin@linaro.org>
 <20160421155753.GS3217@sirena.org.uk>
Message-ID: <20160426110229.GA5374@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, 21 Apr 2016, Mark Brown wrote:

> On Thu, Apr 21, 2016 at 12:04:26PM +0100, Peter Griffin wrote:
> > uniperiph-id, version and mode are ST specific bindings and
> > need the 'st,' prefix. Update the examples, as otherwise copying
> > them yields a runtime error parsing the DT node.
> 
> I'm not sure what connection this or the other ASoC documentation update
> have to the rest of the series?

The ASoC DT bindings are missing upstream as the ASoC driver depends on the
fdma driver. So this series adds the fdma driver, fdma dt bindings,
and also the missing ASoC dt bindings.

Whilst doing this and getting it working I noticed a few discrepencies
in the ASoC dt binding documentation versus the driver so also fixed that.

Once this whole series is applied the end result is working
audio upstream for STi platforms (as ASoC is the only upstream driver
using fdma currently).

regards,

Peter.
