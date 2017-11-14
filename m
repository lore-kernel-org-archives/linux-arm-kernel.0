From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 14 Nov 2017 15:22:04 +0100
Subject: [PATCH v3 4/4] net: nb8800: Add support for suspend/resume
In-Reply-To: <yw1xshdh109j.fsf@mansr.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <ae0d528a-d602-f399-9d75-65bf9bbf1264@sigmadesigns.com>
 <yw1xshdh109j.fsf@mansr.com>
Message-ID: <80649328-8d2a-0a6f-a025-6a6c4de62d7e@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2017 14:02, M?ns Rullg?rd wrote:

> Missing patch description.  Don't bother though.  I won't approve of
> this implementation.

I hope I can convince David that you should not have veto power over
this driver just because it was you who submitted it upstream first.

Per the copyright notice, it was rewritten using Sigma's driver as a
reference. And as of today, only Sigma chips use this driver, a fact
which is unlikely to change, since the IP is no longer sold.

http://www.auroravlsi.com/products.html

> Suspend support has to depend on the chip since the EMAC core doesn't
> have anything of the kind.

Your statement makes no sense to me. If suspending the platform loses
context, then all that is required is saving said context at suspend,
and restoring it at resume.
