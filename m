From: nalajala.murali@gmail.com (Murali N)
Date: Mon, 14 May 2012 12:33:04 +0530
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low power modes
Message-ID: <CAF0TxboSEZuHO6mo-F=os9cvNCyAfVjs3j=SSLjgC7DV6Q_jow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,
I have a query on cache flush sequence being followed for L1 & L2
while target going into deep low power state on CortexA5 MPCore.
Here are the H/W details & the cache flush sequence i am following in
my power driver:

H/W details:
1.?????? ?APPS processor: CortexA5 MPCore
2.?????? ?L2 controller: External PL310 r3p2

Sequences:
a)?While target is going into deep low power mode (where APPS
processor + L2 loose their power) currently I am following the below
cache flush sequence.

1.?L2 cache clean & invalidate
2.?L2 disable
3.?L1 clean & invalidate
4.?L1 disable
5.?WFI

b)?But when I look the PL310 r3p2 TRM (page no 91) explains the
sequence to be followed is bit difference than what I am following.

1.?L1 clean & invalidate
2.?L1 disable
3.?L2 cache clean & invalidate
4.?L2 disable
5.?WFI

Is it mandatory that I would follow only the sequence that is
mentioned in the TRM (i.e. b)? (OR) though TRM says above sequence
(i.e. b) can i still follow the steps (i.e. a)?
What are problems that I see, if I don?t follow what TRM says & follow
the sequence which I have mentioned above (i.e. a)?

Also I have worked on another target with CortexA5 (Single core with
same L2 pl310 controller) where i have followed the sequence ?a? for
quite a long time and don?t see any data corruption issues.

Here my question is, is the above sequence ?b? something special for
only CortexA5MPCore targets to follow?

>From the system stability wise I don?t see any improvement after I
moved to a sequence mentioned in the TRM (i.e. b) for CortexA5 MPCore
target.

Please provide your valuable inputs if you guys have seen similar
issues on other targets?

--
Regards,
Murali N
