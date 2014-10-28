From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 28 Oct 2014 16:48:43 +0800
Subject: [RFC PATCH 4/4] arm64:numa: adding numa support for arm64
 platforms.
In-Reply-To: <CAFpQJXXkgtr6E0owHxAu0MG8+7s5LBt_mVB9gQM1VfkX2rY5FQ@mail.gmail.com>
References: <1411635840-24038-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1411635840-24038-5-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <20141003121343.GG26643@leverpostej>
 <CAFpQJXVJtn=PTYTd5icHhfYxsQnEzUP+w9kXXDJSs-M=eGNWVw@mail.gmail.com>
 <20141006112640.GF24686@leverpostej>
 <CAFpQJXU4AW_WycWUWWaONvCiFgJU5KC_coCH8EU9kO=a0Rf9hQ@mail.gmail.com>
 <CAFpQJXXkgtr6E0owHxAu0MG8+7s5LBt_mVB9gQM1VfkX2rY5FQ@mail.gmail.com>
Message-ID: <544F586B.6080508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ganapatrao,

On 2014-10-18 1:19, Ganapatrao Kulkarni wrote:
[...]
> Below is the example for the proposal of numa bindings in DT.
> This covers cpu to node mapping, memory ranges to node mapping.
> Also defines proximity distance matrix of nodes to each other.
> please let me know your comments to go ahead with the implementation.
> 
> numa-map{
>          /*  Address cells used for memory range base address in mem-map.
>              For all others, size-cells is used.
>              Node-count tells the number of numa nodes in the system.
>          */
>          #address-cells = <2>;
>          #size-cells = <1>;
>          #node-count = <4>;
> 
>          /* Memmap for memory ranges on each node>
> 
>          mem-map = <0x0   0x00c00000 0>,
>            <0x1   0x00000000 1>,
>            <0x100 0x00000000 2>,
>            <0x200 0x00000000 3>;
> 
>          /* CPU to node map for 4 NODE and 16 CPUs system
>         < first-cpu last-cpu  node belongs>

What's the property for the cpu? MPIDR of this CPU?

>          */
>          cpu-map = <0 3 0>,
>                          <4 7 1>,
>                         <8 11 2>,
>                         <12 16 3>;
> 

Thanks
Hanjun
