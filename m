From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 6 Oct 2015 18:23:34 +0200
Subject: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3
 pin on A388-GP
In-Reply-To: <CAPv3WKfOkTHTSXqzZNr+-E20nHr40jqw_Dg6qz24uDa+nB5-BA@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-7-git-send-email-mw@semihalf.com>
 <20151006033131.GA24230@lunn.ch>
 <CAPv3WKeUQ6rsYWJ3C+aX8eHTAdS4SmQ3oCjA9feFf+d-n1RvhA@mail.gmail.com>
 <20151006144523.GA32615@lunn.ch>
 <CAPv3WKfOkTHTSXqzZNr+-E20nHr40jqw_Dg6qz24uDa+nB5-BA@mail.gmail.com>
Message-ID: <20151006162334.GB3557@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We have three options here:
> - leave GPIO-based card detection and see if in future anyone
> complains about not working detection
> - switch to DAT3 detection - yes you're right, that it is a regression
> for all boards < 1.5
> - enable SW polling for detection ("broken-cd") which should satisfy
> all kind of boards

Then i would suggest either broken-cd, or two .dtb blobs and good
comments in the dts files about how to identify the boards and what
happens if you run the wrong DTB blob.

     Andrew
