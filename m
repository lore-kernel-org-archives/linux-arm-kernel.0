From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 19 Feb 2015 18:57:24 +0100
Subject: [RFC/RFT PATCH 0/3] arm64: KVM: work around incoherency with
 uncached guest mappings
In-Reply-To: <20150219175518.GB26965@hawk.usersys.redhat.com>
References: <1424343286-6792-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150219165731.GA26965@hawk.usersys.redhat.com>
 <CAKv+Gu8Je3RRrgEFCZ7JUWtOgk3WqA_qdBEOPAMc3OqnKr1bwg@mail.gmail.com>
 <20150219175518.GB26965@hawk.usersys.redhat.com>
Message-ID: <54E62404.9040702@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/02/2015 18:55, Andrew Jones wrote:
>> > > (I don't have an exact number for how many times it went to EL1 because
>> > >  access_mair() doesn't have a trace point.)
>> > > (I got the 62873 number by testing a 3rd kernel build that only had patch
>> > >  3/3 applied to the base, and counting kvm_toggle_cache events.)
>> > > (The number 50 is the number of kvm_toggle_cache events *without* 3/3
>> > >  applied.)
>> > >
>> > > I consider this bad news because, even considering it only goes to EL2,
>> > > it goes a ton more than it used to. I realize patch 3/3 isn't the final
>> > > plan for enabling traps though.

If a full guest boots, can you try timing a kernel compile?

Paolo
