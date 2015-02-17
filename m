From: Alison_Chaiken@mentor.com (Chaiken, Alison)
Date: Tue, 17 Feb 2015 16:28:28 +0000
Subject: [PATCH] i.MX6: WEIM: put node reference on early loop exit
In-Reply-To: <20150216054702.GF12209@pengutronix.de>
References: <1423848784-6988-1-git-send-email-alison_chaiken@mentor.com>,
 <20150216054702.GF12209@pengutronix.de>
Message-ID: <60BA5429A0E1584BA3633194F6F993B5576E8DB6@NA-MBX-03.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de>
>Looking at the code I get the question why the current code bails out on
>error. Wouldn't it be better to just skip erroneous child devices and
>issue a warning?

The WEIM connects only one child at any given time.   Since it is a platform device, any child is cold-plugged.   If the probe of the child that is marked 'status = "okay"' in the device-tree fails, then the WEIM itself has no function, which sounds more like an error than a warning state.

-- Alison
