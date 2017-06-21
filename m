From: illusionist.neo@gmail.com (Shubham Bansal)
Date: Wed, 21 Jun 2017 19:56:34 +0530
Subject: [PATCH v2] arm: eBPF JIT compiler
In-Reply-To: <59495367.3080402@iogearbox.net>
References: <1495754003-21099-1-git-send-email-illusionist.neo@gmail.com>
 <CAGXu5jKmLNMR+uhM9Ov2XPW6kCjip_SjScgEH0fTFp6fQtKFiA@mail.gmail.com>
 <593E6B0F.8070901@iogearbox.net>
 <CAHgaXd+DW2bggto=2S9hOdMrtPTvhD2QN4rPf2V8iHewQpg-YA@mail.gmail.com>
 <CAHgaXdJrvKdzr3fJ1TMkC4foeVsZJDSVEwhDOeZGxQVsmoK2cQ@mail.gmail.com>
 <59419D1E.2060303@iogearbox.net>
 <CAHgaXdKMbFPgy-kKF0iDSAYo4CqLn9FRu9HwM+OfM-JWb9fNRQ@mail.gmail.com>
 <594813AA.5010001@iogearbox.net>
 <CAHgaXdLtX6yLdU3bMvS=g8FZ79sM_BW_+hHTMH=Mfk4TZqUnpw@mail.gmail.com>
 <59495367.3080402@iogearbox.net>
Message-ID: <CAHgaXdKGJFh8jO44gwCqe0cijoztf39bK9k8ioBtYDjzb4vvZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

>
> So my question would be, why can't the JIT imitate something
> similar to what we do in the interpreter as well? So looking
> at the disasm of what gcc compiles for the interpreter when it's
> doing the above call could help as well in going forward. Not
> sure if that answers your question, but perhaps not sure if I
> understand your question yet?

I just looked at the code again and I think I completely misunderstood
the logic of  BPF_JMP | BPF_CALL.
I think each helper function is working like this.

____helper_function(u32 a1, u32 a2){
}

helper_function(u64 a1, u64 a2){
     ____helper_function((u32 *)a1, (u32 *)a2);
}

So ultimately, we call helper_function which takes u64 as arguments
only. I know its asking a lot, but can you please confirm this asap? I
would like to start implementing it.

>
> Cheers,
> Daniel

-Shubham
