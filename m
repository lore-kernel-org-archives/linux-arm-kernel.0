From: Jeremy.Linton@arm.com (Jeremy Linton)
Date: Wed, 23 Sep 2015 10:22:49 -0700
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <55F059F9.3080200@arm.com>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
 <55F059F9.3080200@arm.com>
Message-ID: <F58048940DF89C44BFA5A966565B5D23EBA361B927@SPOCK.usa.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

|FWIW, mainline booting with this patch on Juno r1 with ACPI enabled dies a
|horrible death:

Sorry about the delay, I didn't see this message.

<trimmed>

|How did you get this to work? Firmware release?

Yes, it's a firmware problem with the ACPI tables. It is likely you need _DSD changes for the SMSC. If your trying to run juno with ACPI there are a few other ACPI table changes you will need beyond what was in the last linaro release. I wanted to just provide a direct link to the correct firmware in this response, but it seems the required version is sort of up in the air at the moment. Be assured I will really push on this next week, and will provide a follow up here.

Originally, the lack of DSD wasn't a problem, but as this patch evolved  the fact that it consolidates a number of configuration code paths balancing that got tricky, and ACPI machines with "bad" tables were the victims (rather than breaking something I can't control).

In the meantime, if this is blocking anyone I can provide instructions on how to update the required ACPI tables.

Thanks,



-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
