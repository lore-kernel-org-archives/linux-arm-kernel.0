From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 4 Sep 2017 11:16:54 +0530
Subject: Applied "regulator: pbias: Select voltage table based on
 max-voltage" to the regulator tree
In-Reply-To: <20170901162322.xrjnim4khn3wfslj@sirena.org.uk>
References: <E1dnO3z-0000tI-7K@debutante>
 <64d9c623-456c-9142-9c5b-a94593628643@ti.com>
 <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
 <CAPDyKFo=UdnVhFU7k+K1=N0e-1sniC+WZjZ4dZKSF8mXhM43Uw@mail.gmail.com>
 <20170901162322.xrjnim4khn3wfslj@sirena.org.uk>
Message-ID: <f50319d6-9b18-0538-4eb1-6ff4226cac02@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Friday 01 September 2017 09:53 PM, Mark Brown wrote:
> On Fri, Sep 01, 2017 at 03:18:03PM +0200, Ulf Hansson wrote:
>> On 31 August 2017 at 15:50, Mark Brown <broonie@kernel.org> wrote:
>>> On Thu, Aug 31, 2017 at 05:37:34PM +0530, Kishon Vijay Abraham I wrote:
> 
>>>> This patch should be merged along with the 1st patch of the series "mmc: host:
>>>> omap_hsmmc: Remove setting PBIAS voltage". Or else it'll break MMC with
>>>> omap_hsmmc driver.
> 
> Hang on, how can this break anything?  If it breaks things shouldn't
> there be bugfixes for incorrect constraints somewhere?

omap_hsmmc sets the pbias voltage to 3V. But here we program the volt table to
support either 1.8V or 3.3V (Initially the volt table was programmed to support
3V because of a bug in TRM). So set_voltage of pbias voltage in omap_hsmmc will
fail.

Thanks
Kishon
