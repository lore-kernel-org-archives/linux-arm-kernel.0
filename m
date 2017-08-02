From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 02 Aug 2017 17:43:05 +0100
Subject: [RFC PATCH v2 0/2] nb8800 suspend/resume support
In-Reply-To: <a7b76388-7a7c-01e0-3966-ff7ebb4df799@free.fr> (Mason's message
 of "Wed, 2 Aug 2017 18:39:08 +0200")
References: <33d1ab47-6098-5e3f-8a3c-f72626d07113@free.fr>
 <aa8885b8-e6bb-3624-2bf9-0bb40505ac54@free.fr>
 <dd883398-1511-0bfd-972b-a11ef8709f0d@free.fr>
 <yw1xshhagexd.fsf@mansr.com>
 <9e8e12b1-74e2-8323-ec16-eebda46b2a3d@free.fr>
 <yw1xo9rygdyu.fsf@mansr.com>
 <6906dccf-bec9-0fc8-a34a-c39c05ada917@free.fr>
 <yw1xk22mgdcx.fsf@mansr.com>
 <a7b76388-7a7c-01e0-3966-ff7ebb4df799@free.fr>
Message-ID: <yw1xfud9hqee.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 02/08/2017 18:10, M?ns Rullg?rd wrote:
>
>> Mason writes:
>> 
>>> On 02/08/2017 17:56, M?ns Rullg?rd wrote:
>>>
>>>> What does the tango5 do if you flood it with packets faster than the
>>>> kernel can keep up with?  That would make it hit the end of the rx
>>>> chain, which is apparently what makes it miserable with the current dma
>>>> stop code.
>>>
>>> The simplest way to test this would be sending tiny packets
>>> as fast as possible, right? So ping -f on a GigE link should
>>> fit the bill?
>> 
>> ping -f is limited to 100 packets per second.  Use something like iperf
>> in UDP mode instead.
>
> ping -f can go 100 times faster than 100 pps:
>
> # ping -f -q -c 150000 -s 300 172.27.64.45
> PING 172.27.64.45 (172.27.64.45) 300(328) bytes of data.
>
> --- 172.27.64.45 ping statistics ---
> 150000 packets transmitted, 150000 received, 0% packet loss, time 15035ms
> rtt min/avg/max/mdev = 0.065/0.084/0.537/0.014 ms, ipg/ewma 0.100/0.087 ms
>
> 150,000 packets in 15 seconds = 10,000 pps
>
> (172.27.64.45 is the tango5 board)
>
> Ergo, dealing with 10,000 packets per second does not hose RX.

ping -f goes as fast as the other end replies or 100 per second,
whichever is higher, so says the man page.

-- 
M?ns Rullg?rd
