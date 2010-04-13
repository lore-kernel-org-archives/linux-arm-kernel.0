From: viresh.kumar@st.com (Viresh KUMAR)
Date: Tue, 13 Apr 2010 16:20:38 +0530
Subject: Query on direction_output fn of PL061 GPIO driver.
Message-ID: <4BC44C7E.20306@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Baruch,

I have a query on PL061 GPIO drivers API pl061_direction_output().
Purpose of this function is to set GPIO pin in OUT mode and set/reset
its value.

In current implementation, firstly value of GPIO pin is modified and then its
direction is set to OUT. In our SOCs (ST SPEAr), this implementation doesn't
work correctly (we have pl061 in our soc). Suppose previously pin is in IN mode,
now writing val to it doesn't change anything because it is in IN mode and we
can write to a pin only when it is in OUT mode. Now if its direction is
changed to OUT then also its value will remain same and will not be changed to
what we wanted.


Am i missing something?

regards,
viresh kumar.
