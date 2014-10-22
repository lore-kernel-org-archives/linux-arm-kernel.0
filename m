From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 22 Oct 2014 16:57:43 +0530
Subject: [RFC PATCH 4/4] arm64:numa: adding numa support for arm64
 platforms.
In-Reply-To: <20141020143045.GA10233@linaro.org>
References: <1411635840-24038-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1411635840-24038-5-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <20141003121343.GG26643@leverpostej>
 <CAFpQJXVJtn=PTYTd5icHhfYxsQnEzUP+w9kXXDJSs-M=eGNWVw@mail.gmail.com>
 <20141006112640.GF24686@leverpostej>
 <CAFpQJXU4AW_WycWUWWaONvCiFgJU5KC_coCH8EU9kO=a0Rf9hQ@mail.gmail.com>
 <CAFpQJXXkgtr6E0owHxAu0MG8+7s5LBt_mVB9gQM1VfkX2rY5FQ@mail.gmail.com>
 <20141020142555.GA9968@linaro.org>
 <20141020143045.GA10233@linaro.org>
Message-ID: <CAFpQJXUQsxGRxQroZ1X0pbHp5n=TymaP0r662NU0WetM_oZUKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 8:00 PM, Steve Capper <steve.capper@linaro.org> wrote:
> On Mon, Oct 20, 2014 at 03:25:56PM +0100, Steve Capper wrote:
>> On Fri, Oct 17, 2014 at 10:49:56PM +0530, Ganapatrao Kulkarni wrote:
>
> [...]
>
>>          /*Proximity Distance matrix for 4Node system
>> >                        <from-node to-node distance>
>> >         */
>> >          node-matrix=    <0 0 10>,
>> >                                <0 1 20>,
>> >                                <0 2 30>,
>> >                                <0 3 10>,
>> >                                <1 0 20>,
>> >                                 <1 1 10>,
>> >                                <1 2 30>,
>> >                               <1 3 10>,
>> >                               <2 0 30>,
>> >                               <2 1 20>,
>> >                               <2 2 10>,
>> >                              <2 3 10>,
>> >                             <3 0 10>,
>> >                             <3 1 20>,
>> >                             <3 2 30>,
>> >                             <3 3 10>,
>> >  }
>>
>> Hi Ganapat,
>> The above caught my attention.
>>
>> For a 4-node system do we not need 16 distances; the implication of that
>> would be that the distance between node A-B could be different from the
>> distance between B-A? Also the distance from a node to itself could be
>> safely assumed to be zero?
>>
>> I think we should have a symmetric matrix with zero-diagonals so strictly
>> only seven values would need specifying for a 4-node system.
Thanks Stave for the comments.
I too thought initially to take the assumption like
distance B-A is same as A-B and A-A is always defined to LOCAL.
However this example is an ideal case which will define all 16
distances for 4 node system.
In actual DT, we can skip to provide A-A and B-A, In kernel
implementation we will use these common/generic assumptions
to derive missing distances.
>
> s/seven/six/
>
> I really need to learn how to count.... :-/
>
>>
>> Cheers,
>> --
>> Steve
thanks
Ganapat
