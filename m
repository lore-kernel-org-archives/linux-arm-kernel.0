From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 6 Jan 2017 09:49:13 -0600
Subject: [PATCH v2 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <54ceb523-47ea-f137-293f-0da0166bb14b@codeaurora.org>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-2-cov@codeaurora.org>
 <ac275374-2aa6-43ec-25c9-6a3fec4ceedc@codeaurora.org>
 <54ceb523-47ea-f137-293f-0da0166bb14b@codeaurora.org>
Message-ID: <e1f88cbb-f3b8-7de4-4aed-004c7610da0a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christopher Covington wrote:
>> > Also, since this can't be changed via the menu, why bother putting it in?
> I put it in in response to review comments asking for the magic number to
> be clarified by a #define or variable. I could not find a suitably shared
> header between the files in question, so I used the Kconfig machinery to
> generate the #define.

I don't think that's the right approach.  Kconfigs are not an 
alternative to header files.  Is the ASID configurable?  If you just put 
some text after the "int" then it because a menu option that the user 
can select and change.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
