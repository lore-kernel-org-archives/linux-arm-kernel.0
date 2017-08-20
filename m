From: ast@fb.com (Alexei Starovoitov)
Date: Sat, 19 Aug 2017 19:11:51 -0700
Subject: [PATCH net-next v3] arm: eBPF JIT compiler
In-Reply-To: <CAHgaXdJDOseZk0=4uCGeCx44kgnvHf1gnh7CX2c6dTzXb8Rk+g@mail.gmail.com>
References: <1503134429-29063-1-git-send-email-illusionist.neo@gmail.com>
 <c2f4c796-0cb0-7eca-6cab-fed6b25020d5@fb.com>
 <CAHgaXdJnHxu4gJ8ZVFmrmaXyZL1oFkTbz2K___xKLQedTLmBQg@mail.gmail.com>
 <9d77730f-c6a8-b337-599e-5919207a7e0a@fb.com>
 <CAHgaXd+hccuUYXfTs6gMbvxBctrypofc2FJ10q3QAc0jGsgeyQ@mail.gmail.com>
 <CAHgaXdJDOseZk0=4uCGeCx44kgnvHf1gnh7CX2c6dTzXb8Rk+g@mail.gmail.com>
Message-ID: <b63fae4b-cb74-1928-b210-80914f3c8995@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/19/17 2:46 PM, Shubham Bansal wrote:
> test_pkt_access:PASS:ipv4 271 nsec
> test_pkt_access:PASS:ipv6 297 nsec
> test_xdp:PASS:ipv4 961517 nsec     <--- Here is the difference.
> test_xdp:PASS:ipv6 615855 nsec     <--- Here is the difference.

yes. this is expected. These two numbers are single run
on cold cache, so there will be run-to-run variation.

> test_l4lb:PASS:ipv4 3049 nsec
> test_l4lb:PASS:ipv6 3906 nsec

These two and the first two were the ones I was interested in,
since they do many iterations over the same set and
the best to compare code gen changes.
The delta % is actually better than I expected judging by test_bpf
micro-benchmarks, so the results are very encouraging.

Thanks!
