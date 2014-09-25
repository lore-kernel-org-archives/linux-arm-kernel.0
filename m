From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 25 Sep 2014 18:44:05 +0200
Subject: Holes management in syscon driver
Message-ID: <54244655.1090801@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong, all,

We use syscon driver on our STi platforms to manage our system config registers.
We declare one syscon instance per sysconf bank.

The problem we are facing is that these banks have holes, and when using regmap's debugfs interface to dump the registers, we get imprecise aborts.

My first idea would be do implement the .readable_reg and .writeable_reg callbacks offered by regmap in syscon driver, and provide ranges where there are registers via DT.
But I am not sure how would look the DT bindings.

What is your view on this?
Are other syscon users having the same issue?

Regards,
Maxime
