From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 15 Jul 2016 20:01:13 +0800
Subject: "coupled" regulator support
Message-ID: <20160715200113.0f3cd823@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I dunno how to name this kind of regulator, my situation is:

multiple devices connects to one voltage regulator_dev, e.g devA and devB connects
to regR, regR only support two voltage v1 and v2, let's say v1 < v2

regR can only be set to v1 if devA and devB all call for set voltage to v1
regR can set to v2 if devA or devB call for set voltage to v2

To support this situation, I'd like to add flag to regulator structure and
patch regulator_check_consumers() to check whether we are safe to set the vol

Is this patch acceptable or we already have elegant solution?

Thanks in advance,
Jisheng
