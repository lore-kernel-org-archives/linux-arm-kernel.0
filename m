From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Sat, 3 Apr 2010 20:12:56 +0200
Subject: Regulators vis-a-vis Power Domains
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B180320EBB6@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello All,
?
I have a few queries about regulators vis-a-vis power domains.
?
1. The documentation for the regulators mentions "power domains" and "switches" to be modeled as regulators. I am planning to model multiple "switches" for controlling supplies to various peripherals from a main master regulator as multiple regulators, childed from the parent regulator. Is this the right way to proceed ahead? Further the options for these switches will be only?a logical on/off. (BTW, I saw lots of TI stuff which is something related to power domains, but it doesn't model the regulator framework.)
?
2. In the same example below, should I instead model just the main regulator, and in the driver specific enable/disable, iterate through the list of consumers, and then accordingly enable/disable these switches according to the calling consumer?. In this way,?I can choose not to clutter those smaller switches as regulators in my regulator as well as peripheral driver code.?
?
3. Extending the same model, I want to use the _set_optimum API. Logically, enabling/disabling the child supply or setting an optimal load on the regulator must propagate the new load to any master regulator ( which can then again be set an optimal load). My understanding of this function shows me that?currently, this is not supported in the function. Am I right in deducing this or?have I failed to overlook some other portions in the regulator code?
?
Waiting for all your valuable replies!
?
Sundar
