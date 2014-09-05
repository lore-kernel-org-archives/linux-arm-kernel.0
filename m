From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 5 Sep 2014 13:39:52 +0100
Subject: [PATCH 1/2] arm64: psci: respect MIGRATE_INFO_TYPE
In-Reply-To: <5409A571.8060502@cogentembedded.com>
References: <1409916139-20127-1-git-send-email-mark.rutland@arm.com>
 <1409916139-20127-2-git-send-email-mark.rutland@arm.com>
 <5409A571.8060502@cogentembedded.com>
Message-ID: <20140905123951.GB20164@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > +	if (psci_ops.migrate_info_type &&
> > +		psci_ops.migrate_info_type() != PSCI_0_2_TOS_MP) {
> > +			pr_warn("Unable to handle UP trusted OS\n");
> > +			return -EPERM;
> 
>     The above 2 lines are indented too much to the right.

Noted; locally fixed. Thanks.

The logic is the same regardless, so I won't send out a v2 unless
someone has an issue with that logic, rather than the style.

Mark.
