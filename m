From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 13 Apr 2017 15:31:38 +0800
Subject: [PATCH 5/6] regulator: anatop-regulator: make regulator-name
 using optionally
In-Reply-To: <20170411203817.5f32em4v5xiwzchl@sirena.org.uk>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
 <1491962327-12477-5-git-send-email-aisheng.dong@nxp.com>
 <20170411203817.5f32em4v5xiwzchl@sirena.org.uk>
Message-ID: <20170413073138.GB23163@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 09:38:18PM +0100, Mark Brown wrote:
> On Wed, Apr 12, 2017 at 09:58:46AM +0800, Dong Aisheng wrote:
> > rdesc->name/regulator-name is optional according to standard regulator
> > binding doc. Use it conditionally to avoid a kernel NULL point crash.
> 
> It is optional in the standard binding because it is used to override
> the name statically provided in the driver for the device.  Since the
> anatop regulator is completely dynamic (there's no static list of
> regulators in the device) it's mandatory for anatop regulators - you
> should improve the error handling instead to detect a missing name.

Got it. Will change in v2.
Thanks for the suggestion.

Regards
Dong Aisheng
