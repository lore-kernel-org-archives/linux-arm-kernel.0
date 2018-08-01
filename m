From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 31 Jul 2018 23:15:15 -0700
Subject: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
In-Reply-To: <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
 <20180730143043.qu66ttzwyjbw6si7@localhost>
 <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Message-ID: <20180801061515.krn52iaq2kqdi3wo@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2018 at 04:36:40AM +0000, Y.b. Lu wrote:

> Could I add a function to calculate a set of default register values
> to initialize ptp timer when dts method failed to get required
> properties in driver?

Yes, it would be ideal if the driver can pick correct values
automatically.

However, the frequency on the FIPER outputs can't be configured
automatically, and we don't have an API for the user to choose this.

> I think this will be useful. The ptp timer on new platforms (you may
> see two dts patches in this patchset. Many platforms will be
> affected.) will work without these dts properties. If user want
> specific setting, they can set dts properties.

Sure.

Thanks,
Richard
